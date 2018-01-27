RSpec.describe RsasController do

it 'does it encrypts' do
post :newKey, as: :json
parsed_body = JSON.parse(response.body)
expect(parsed_body.has_key?('id')).to eq true

end

it 'does it encrypts with params' do
post :newKey,params: {n: 1 ,e: 6,d: 5}, as: :json
parsed_body = JSON.parse(response.body)
expect(parsed_body.has_key?('id')).to eq true
get :printKey, params: {id: parsed_body["id"]}, as: :json
parsed_body = JSON.parse(response.body)
expect(parsed_body['d']).to eq 5
expect(parsed_body['n']).to eq 1
expect(parsed_body['e']).to eq 6
end



end
