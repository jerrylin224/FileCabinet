class DocsController < ApplicationController
  before_action :find_doc, only: [:show, :edit, :updeate, :destroy]

  def index
    @docs  = Doc.all.order("created_at DESC")
  end

  def show
    find_doc
  end

  def new
    @doc = current_user.docs.build
  end

  def create
    @doc = current_user.docs.build(doc_params)

    if @doc.save
      redirect_to docs_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @doc.update(doc_params)
      redirect_to @doc
    else
      render 'edit'
    end
  end

  def destroy
    @doc.destroy
    redirect_to docs_path
  end

  private

    def find_doc
      # @doc = Doc.find(id: doc_params[:id])      
      @doc = Doc.find(params[:id])
    end

    def doc_params
      params.require(:doc).permit(:title, :content)
    end
end
