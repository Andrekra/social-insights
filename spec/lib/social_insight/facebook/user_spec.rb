describe SocialInsight::Facebook::User do
  describe 'accounts' do
    let(:token){ ENV['FACEBOOK_USER_TOKEN'] }
    let(:service){ SocialInsight::Facebook::User.new(token) }

    it 'should not include accounts if the user does not have the CREATE_CONTENT permission' do
      VCR.use_cassette 'accounts' do
        expect(service.accounts.size).to eql 1
      end
    end

    it 'should include details of a page' do
      VCR.use_cassette 'accounts' do
        page = service.accounts.first
        expect(page.keys).to eql [:social_uid, :title, :reach, :last_post_date, :access_token]
      end
    end

    it 'should raise an error if token is invalid' do
      VCR.use_cassette 'invalid_user_token' do
        service = SocialInsight::Facebook::User.new 'FAKE'
        expect{service.accounts}.to raise_error(SocialInsight::Errors::AuthorizationError)
      end
    end

  end
end
