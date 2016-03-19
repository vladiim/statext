require 'spec_helper'

RSpec.describe '/auth', type: :controller do

  describe '/create' do
    let(:params) {{}}
    before { post '/auth/create', params }

    context 'without email' do
      it 'fails' do
        expect(last_response.body).to eq('No email received!')
      end
    end
  end
end
