module V1
  class ContactsController < ApplicationController
    include ErrorSerializer
    before_action :set_contact, only: [:show, :update, :destroy]

    # GET /contacts
    def index
      page_number = params[:page].try(:[], :number)
      page_size = params[:page].try(:[], :size)
      @contacts = Contact.all.page(page_number).per(page_size)

      # Cache-Control --- expires_in 30.seconds, public: true

      # Etag
      # if stale?(etag: @contacts)
      #   render json: @contacts #, methods: [:hello, :i18n]
      # end

      # Last-Modified
      #if stale?(last_modified: @contacts[0].updated_at)
        render json: @contacts #, methods: [:hello, :i18n]
      #end

      # paginate json: @contacts #, methods: [:hello, :i18n]
    end

    # GET /contacts/1
    def show
      render json: @contact #, include: [:kind, :phones, :address]#, meta: { author: "Danilo Isidoro" }
    end

    # POST /contacts
    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        render json: @contact, include: [:kind, :phones, :address], status: :created, location: @contact
      else
        render json: ErrorSerializer.serialize(@contact.errors) # @contact.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /contacts/1
    def update
      if @contact.update(contact_params)
        render json: @contact, include: [:kind, :phones, :address]
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    # DELETE /contacts/1
    def destroy
      @contact.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = Contact.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def contact_params
        # params.require(:contact).permit(
        #   :name,
        #   :email,
        #   :birthdate,
        #   :kind_id,
        #   phones_attributes: [
        #     :id,
        #     :number,
        #     :_destroy
        #   ],
        #   address_attributes: [
        #     :id,
        #     :street,
        #     :city
        #   ]
        # )
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  end
end
