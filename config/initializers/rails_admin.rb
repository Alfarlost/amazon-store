RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  ## == Cancan ==
  config.authorize_with :cancan



  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

    ## With an audit adapter, you can add:
    # history_index
    # history_show

    config.model 'Book' do
      list do
        field :title
        field :description
        field :author
        field :category
        field :price
        field :avatar
      end
    end

    config.model 'Author' do
      list do
        field :first_name
        field :last_name
        field :biography
      end
    end
  
    config.model 'Category' do
      list do
        field :name
      end
    end

      config.model 'Order' do
          field :state, :enum do
            enum do
              ["in progress", "complited", "shipped"]
            end
          end
      end




end
