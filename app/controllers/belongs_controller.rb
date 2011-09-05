class BelongsController < ApplicationController
  # GET /belongs
  # GET /belongs.xml
  def index
    @belongs = Belong.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @belongs }
    end
  end

  # GET /belongs/1
  # GET /belongs/1.xml
  def show
    @belong = Belong.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @belong }
    end
  end

  # GET /belongs/new
  # GET /belongs/new.xml
  def new
    @belong = Belong.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @belong }
    end
  end

  # GET /belongs/1/edit
  def edit
    @belong = Belong.find(params[:id])
  end

  # POST /belongs
  # POST /belongs.xml
  def create
    @belong = Belong.new(params[:belong])

    respond_to do |format|
      if @belong.save
        flash[:notice] = 'Belong was successfully created.'
        format.html { redirect_to(@belong) }
        format.xml  { render :xml => @belong, :status => :created, :location => @belong }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @belong.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /belongs/1
  # PUT /belongs/1.xml
  def update
    @belong = Belong.find(params[:id])

    respond_to do |format|
      if @belong.update_attributes(params[:belong])
        flash[:notice] = 'Belong was successfully updated.'
        format.html { redirect_to(@belong) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @belong.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /belongs/1
  # DELETE /belongs/1.xml
  def destroy
    @belong = Belong.find(params[:id])
    @belong.destroy

    respond_to do |format|
      format.html { redirect_to(belongs_url) }
      format.xml  { head :ok }
    end
  end
end
