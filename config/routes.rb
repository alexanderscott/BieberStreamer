BieberStreamer::Application.routes.draw do

  # Socket routes
  get "socket", to: "sockets#stream"

  # Page routes
  root "pages#index"

end
