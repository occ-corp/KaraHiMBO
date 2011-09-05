# -*- coding: utf-8 -*-
class ItemsController < ApplicationController
  # GET /items
  # GET /items.xml
  def index
    @items = Item.find(:all, :order => :id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find_with_categories(params[:id])
    @root_division = params[:root_division] || 0
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    if params[:second_category_id].nil? || params[:division_id].nil?
      flash[:notice] = t(:second_categories_controller_select_division)
      redirect_to :controller => :objective, :action => :maintenance
    else
      @item = Item.new(:second_category_id => params[:second_category_id])
      @root_division = params[:division_id]

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @item }
      end
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    @root_division = params[:root]
    @selected_divisions = @item.divisions.collect { |d| d.id }
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])

    @root_division = params[:root_division]
    params[:division_id] ||= Array.new
    @selected_divisions = params[:division_id].map { |d| d.to_i } 
    
    respond_to do |format|
      begin
        @item.divisions << Division.find(@selected_divisions)
        @item.save!
        flash[:notice] = t(:items_controller_created, :item_name => @item.name)
        format.html { redirect_to_maintenance(@root_division) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      rescue
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])
    @root_division = params[:root_division]
    params[:division_id] ||= Array.new
    @selected_divisions = params[:division_id].map { |d| d.to_i } 

    respond_to do |format|
      begin
        @item.divisions.clear
        @item.divisions << Division.find(@selected_divisions)
        @item.update_attributes!(params[:item])
        flash[:notice] = t(:items_controller_updated, :item_name => @item.name)
        format.html { redirect_to_maintenance(@root_division) }
        format.xml  { head :ok }
      rescue
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    root_division = params[:root_division]
    name = @item.name
    @item.destroy

    respond_to do |format|
      flash[:notice] = t(:items_controller_destroyed, :name => name)
      format.html { redirect_to_maintenance(root_division) }
      format.xml  { head :ok }
    end
  end

  def replace_unit
    unit = params[:value]

    render :update do |page|
      page.select('span.unit_name').each do |d|
        page.replace_html d, unit
      end
    end
  end
end
