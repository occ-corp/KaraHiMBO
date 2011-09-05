class DivisionsItemsController < ApplicationController
  # GET /divisions_items
  # GET /divisions_items.xml
  def index
    @divisions_items = DivisionsItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @divisions_items }
    end
  end

  # GET /divisions_items/1
  # GET /divisions_items/1.xml
  def show
    @divisions_item = DivisionsItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @divisions_item }
    end
  end

  # GET /divisions_items/new
  # GET /divisions_items/new.xml
  def new
    @divisions_item = DivisionsItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @divisions_item }
    end
  end

  # GET /divisions_items/1/edit
  def edit
    @divisions_item = DivisionsItem.find(params[:id])
  end

  # POST /divisions_items
  # POST /divisions_items.xml
  def create
    @divisions_item = DivisionsItem.new(params[:divisions_item])

    respond_to do |format|
      if @divisions_item.save
        flash[:notice] = 'DivisionsItem was successfully created.'
        format.html { redirect_to(@divisions_item) }
        format.xml  { render :xml => @divisions_item, :status => :created, :location => @divisions_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @divisions_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /divisions_items/1
  # PUT /divisions_items/1.xml
  def update
    @divisions_item = DivisionsItem.find(params[:id])

    respond_to do |format|
      if @divisions_item.update_attributes(params[:divisions_item])
        flash[:notice] = 'DivisionsItem was successfully updated.'
        format.html { redirect_to(@divisions_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @divisions_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /divisions_items/1
  # DELETE /divisions_items/1.xml
  def destroy
    @divisions_item = DivisionsItem.find(params[:id])
    @divisions_item.destroy

    respond_to do |format|
      format.html { redirect_to(divisions_items_url) }
      format.xml  { head :ok }
    end
  end
end
