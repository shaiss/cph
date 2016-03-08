class CphController < ApplicationController
  def home
    ## note that rails won't pick up url's in this format:
    ## http://blah.com/#page_thing?blah=blah which is what the dreamhost
    ## script returns when you sign up for an email.  I've not looked into
    ## where the problem lies (DH, or Rails)... not a big enough problem
    ## for me to figure it out now.
    @email          = params[:address].blank? ? '' : params[:address]
    @name           = params[:name].blank? ? '' : params[:name]
    @image          = choose_image
    @amy_years      = amy_years
    @amy_kids_ages  = amy_kids_ages
    @faith_years    = faith_years
    @big_years      = big_years
    @little_years   = little_years
    @display_winner = display_winner?
    @winning_ticket = 531686
    @tuition_dates  = '2015 - 2016'
    @tuition_cost   = 3500
  end

  private
    ## this is meant to choose the first image that will be displayed in the
    ## banner box.  Obviously pretty simple, and doesn't take into account the
    ## jquery stuff that chooses images either.
    def choose_image
      "banners/#{ rand(35) + 1 }.jpg"
    end

    ## this sets the number of years amy has been an educator.
    def amy_years
      (Time.now.year - 1977).ordinalize
    end

    ## sets amys kids ages
    def amy_kids_ages
      [ Time.now.year - 1996, Time.now.year - 1985].join(' to ')
    end

    ## faiths years at playschool
    def faith_years
      (Time.now.year - 1991).ordinalize
    end

    def big_years
      Time.now.year - 1998
    end

    def little_years
      Time.now.year - 2004
    end

    def display_winner?
      Date.new(2011,11,15) >= Date.today
    end
end
