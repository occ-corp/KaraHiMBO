# -*- coding: utf-8 -*-
class FirstCategoriesController < ApplicationController
  # GET /first_categories
  # GET /first_categories.xml
  def index
    @first_categories = FirstCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @first_categories }
    end
  end

  # GET /first_categories/1
  # GET /first_categories/1.xml
  def show
    @first_category = FirstCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @first_category }
    end
  end

  # GET /first_categories/new
  # GET /first_categories/new.xml
  def new
    @first_category = FirstCategory.new
    if params[:division_id]
      @first_category.division_id = params[:division_id].to_i
      
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @first_category }
      end
    else
      redirect_to_maintenance
    end
  end

  # GET /first_categories/1/edit
  def edit
    @first_category = FirstCategory.find(params[:id])
  end

  # POST /first_categories
  # POST /first_categories.xml
  def create
    @first_category = FirstCategory.new(params[:first_category])

    respond_to do |format|
      if @first_category.save
        flash[:notice] = t(:first_categories_controller_created, :first_category_name => @first_category.name)
        format.html { redirect_to_maintenance(@first_category.division_id) }
        format.xml  { render :xml => @first_category, :status => :created, :location => @first_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @first_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /first_categories/1
  # PUT /first_categories/1.xml
  def update
    @first_category = FirstCategory.find(params[:id])

    respond_to do |format|
      if @first_category.update_attributes(params[:first_category])
        flash[:notice] = t(:first_categories_controller_updated, :first_category_name => @first_category.name)
        format.html { redirect_to_maintenance(@first_category.division_id) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @first_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /first_categories/1
  # DELETE /first_categories/1.xml
  def destroy
    @first_category = FirstCategory.find(params[:id])
    division_id = @first_category.division_id
    name = @first_category.name
    @first_category.destroy

    respond_to do |format|
      flash[:notice] = t(:first_categories_controller_destroyed, :name => name)
      format.html { redirect_to_maintenance(division_id) }
      format.xml  { head :ok }
    end
  end
end
