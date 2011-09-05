# -*- coding: utf-8 -*-
class SecondCategoriesController < ApplicationController
  # GET /second_categories
  # GET /second_categories.xml
  def index
    @second_categories = SecondCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @second_categories }
    end
  end

  # GET /second_categories/1
  # GET /second_categories/1.xml
  def show
    @second_category = SecondCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @second_category }
    end
  end

  # GET /second_categories/new
  # GET /second_categories/new.xml
  def new
    @second_category = SecondCategory.new(:first_category_id => params[:first_category_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @second_category }
    end
  end

  # GET /second_categories/1/edit
  def edit
    @second_category = SecondCategory.find(params[:id])
  end

  # POST /second_categories
  # POST /second_categories.xml
  def create
    @second_category = SecondCategory.new(params[:second_category])

    respond_to do |format|
      if @second_category.save
        flash[:notice] = t(:second_categories_controller_created, :second_category_name => @second_category.name)
        format.html { redirect_to_maintenance(@second_category.first_category.division_id) }
        format.xml  { render :xml => @second_category, :status => :created, :location => @second_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @second_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /second_categories/1
  # PUT /second_categories/1.xml
  def update
    @second_category = SecondCategory.find(params[:id])

    respond_to do |format|
      if @second_category.update_attributes(params[:second_category])
        flash[:notice] = t(:second_categories_controller_updated, :second_category_name => @second_category.name)
        format.html { redirect_to_maintenance(@second_category.first_category.division_id) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @second_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /second_categories/1
  # DELETE /second_categories/1.xml
  def destroy
    @second_category = SecondCategory.find(params[:id])
    division_id = @second_category.first_category.division.id
    name = @second_category.name
    @second_category.destroy

    respond_to do |format|
      flash[:notice] = t(:second_categories_controller_destroyed, :name => name)
      format.html { redirect_to_maintenance(division_id) }
      format.xml  { head :ok }
    end
  end
end
