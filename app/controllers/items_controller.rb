class ItemsController < ApplicationController

  def index
    @items=Item.all
  end




  def show
    # require "pry"
    # binding.pry
    @item=Item.find(params[:id]||params[:name])
    @category=Category.find(@item.category_id)
  end


  def new
		@item=Item.new
	end

  def create
		@item=Item.new(item_params)

		if @item.save
      @category=Category.find(@item.category_id)
#variable for view  #model
		    redirect_to "/categories/#{@category.name}/items/#{@item.id}"

		else
			render :new
		end
	end

  def edit

    @item = Item.find_by(id: params[:id])

    logger.info @item.inspect
  end


  def update

      # @categories=category(params[:id])

      @item=Item.find(params[:id])


      if @item.update_attributes(item_params)
        redirect_to root_path
      else
        render :edit
      end
  end

  def destroy
    # logger.info @item.inspect
      @item=Item.find(params[:id])
      @item.destroy
      redirect_to root_path
  end

  def search
    # raise params.inspect
    @item = Item.search(params)
  end



private
  def item_params
    params.require(:item).permit(:name,:location, :price, :description, :category_id, :phone_number)

  end

end
