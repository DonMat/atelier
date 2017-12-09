require "rails_helper"

RSpec.describe 'Book routes', type: :routing do
  it { expect(get: '/').to route_to('books#index') }
  it { expect(get: '/books').to route_to('books#index') }
  it { expect(post: '/books').to route_to('books#create') }
  it { expect(get: '/books/new').to route_to('books#new') }
  it { expect(get: '/books/1').to route_to('books#show', id: '1') }
end
