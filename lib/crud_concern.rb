module CrudConcern
  extend ActiveSupport::Concern

  def index
    render json: resource, include: inclusions, meta: meta
  end

  def show
    render json: resource, include: inclusions
  end

  def create
    if resource.valid?
      yield(resource) if block_given?
      resource.save!
      render json: resource
    else
      render json: resource,
        status: :unprocessable_entity, serializer: ErrorSerializer
    end
  end

  def update
    if resource.update_attributes(attributes)
      render json: resource
    else
      render json: ErrorSerializer.serialize(resource.errors),
        status: :unprocessable_entity
    end
  end

  def destroy
    render json: resource.destroy
  end

  private

  def resource
    @resource ||= if params[:id]
      klass.unscoped.find(params[:id])
    else
      scope.order(params[:sort])
    end
  end

  def scope
    klass.all
  end

  def meta
    { total: scope.count }
  end

  def deserialize(hash)
    ActiveModelSerializers::Deserialization.jsonapi_parse(hash)
  end

  def attributes
    @attributes ||= deserialize(params)
  end

  def klass
    self.class.name.gsub('Controller','').singularize.constantize
  end

  def inclusions
    params[:include]
  end

  def limit
    params[:limit].to_i || 50
  end

  def offset
    page = params[:page] ? params[:page].to_i - 1 : 0
    page * limit
  end
end
