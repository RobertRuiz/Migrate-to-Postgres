require_relative 'models'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'rack-flash'

# use Rack::MethodOverride
# use Rack::Flash

# homepage
get '/' do
  @terms = Term.all.take(5)
  @categories = Category.all

  erb :homepage
end

# terms index
get '/terms' do
  @terms = Term.all

  erb :terms_index
end

# terms new
get '/terms/new' do
  erb :terms_new
end

# terms search
post '/terms/search' do
  @name = params["name"]
  @definition = params["definition"]

  term = Term.where("name like '%#{@name}%'").first
  term = Term.where("definition like '%#{@definition}%'").first
  if term
    redirect "/terms/#{term.id}"
  else
    erb :not_found
  end
end

# terms show
get '/terms/:id' do
  # Lets fetch the ID from the URL so we know which term we are showing
  id = params["id"]

  # Lets go fetch that term from the database
  @term = Term.find_by(id: id)

  # if we have a term, lets render the template
  if @term
    erb :terms_show
  else
    # otherwise, just send the user back to the terms index page (e.g. "/terms")
    redirect "/terms"
  end
end

# Terms create
post '/terms' do
  # Add the term
  term = Term.create(params["term"])

  # Navigate to the terms page
  redirect "/terms"
end

# terms edit
get '/terms/:id/edit' do
  # Get the id from the parameters
  id = params["id"]

  # Fetch the term from the database
  @term = Term.find_by(id: id)

  erb :terms_edit
end

# terms update
put '/terms/:id' do
  # Fetch the id form the params
  id = params["id"]

  # Get the term from the database
  term = Term.find_by(id: id)

  # Update the attributes of this term (saving to the database)
  term.update_attributes(params["term"])

  # Send the user back to the show page for this term
  redirect "/terms/#{term.id}"
end

# terms delete
delete '/terms/:id' do
  # Get the id from the params
  id = params["id"]

  # Fetch the term from the database
  term = Term.find_by(id: id)

  # Delete the term
  term.delete

  # Redirect the user to the terms index
  redirect '/terms'
end

# categories index
get '/categories' do
  @categories = Category.all

  erb :categories_index
end

# categories new
get '/categories/new' do
  erb :categories_new
end

# categories create
post '/categories' do
  # Add the category
  category = Category.create(params["category"])

  # Navigate to the categories page
  redirect "/categories"
end
