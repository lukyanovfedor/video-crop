require 'rails_helper'

RSpec.describe Api::V1::InquiriesController, type: :controller do
  let!(:user) { FactoryGirl.create :user }
  let!(:inquiry) { FactoryGirl.create :inquiry, user: user }
  let(:ability) { create_ability }

  describe '#create' do
    context 'with valid token' do
      before do
        ability.can :manage, Inquiry
        allow_access_for(user)
      end

      context 'inquiry valid' do
        before do
          allow(Inquiry).to receive(:new) { inquiry }
          allow(inquiry).to receive(:valid?) { true }
          allow(inquiry).to receive(:save!) { true }
        end

        it 'expect to render create template' do
          post :create, format: :json
          expect(response).to render_template('create')
        end

        it 'expect to assign @inquiry' do
          post :create, format: :json
          expect(assigns(:inquiry)).not_to be_nil
        end

        it 'expect to receive :valid?' do
          expect(inquiry).to receive(:valid?)
          post :create, format: :json
        end

        it 'expect to receive :valid?' do
          expect(inquiry).to receive(:save!)
          post :create, format: :json
        end
      end

      context 'inquiry invalid' do
        before do
          allow(Inquiry).to receive(:new) { inquiry }
          allow(inquiry).to receive(:valid?) { false }
        end

        it 'expect to render error template' do
          post :create, format: :json
          expect(response).to render_template('api/v1/errors/show')
        end
      end
    end

    context 'without valid token' do
      it 'expect to render error template' do
        post :create, format: :json
        expect(response).to render_template('api/v1/errors/show')
      end
    end

    context 'without abilities' do
      before do
        allow_access_for(user)
        ability.cannot :manage, Inquiry
      end

      it 'expect to render error template' do
        post :create, format: :json
        expect(response).to render_template('api/v1/errors/show')
      end
    end
  end

  describe '#index' do
    context 'with valid token' do
      before do
        ability.can :manage, Inquiry
        allow_access_for(user)
      end

      it 'expect to render index template' do
        get :index, format: :json
        expect(response).to render_template('index')
      end

      it 'expect to return 200 http status' do
        expect(response.status).to eq 200
        get :index, format: :json
      end

      it 'expect to assign @inquiries' do
        get :index, format: :json
        expect(assigns(:inquiries)).not_to be_nil
      end
    end

    context 'without valid token' do
      it 'expect to render error template' do
        get :index, format: :json
        expect(response).to render_template('api/v1/errors/show')
      end
    end

    context 'without abilities' do
      before do
        allow_access_for(user)
        ability.cannot :manage, Inquiry
      end

      it 'expect to render error template' do
        get :index, format: :json
        expect(response).to render_template('api/v1/errors/show')
      end
    end
  end

  describe '#restart' do
    context 'with valid token' do
      before do
        ability.can :manage, Inquiry
        allow_access_for(user)
      end

      context 'inquiry has failed state' do
        before do
          allow(Inquiry).to receive(:find) { inquiry }
          allow(inquiry).to receive(:failed?) { true }
          allow(inquiry).to receive(:crop_video) { true }
        end

        it 'expect to render show template' do
          post :restart, id: inquiry.id.to_s, format: :json
          expect(response).to render_template('create')
        end

        it 'expect to return 200 http status' do
          expect(response.status).to eq 200
          post :restart, id: inquiry.id.to_s, format: :json
        end

        it 'expect to assign @inquiry' do
          post :restart, id: inquiry.id.to_s, format: :json
          expect(assigns(:inquiry)).not_to be_nil
        end

        it 'expect to receive :restart!' do
          expect(inquiry).to receive(:restart!)
          post :restart, id: inquiry.id.to_s, format: :json
        end

        it 'expect to receive :restart!' do
          expect(inquiry).to receive(:crop_video)
          post :restart, id: inquiry.id.to_s, format: :json
        end
      end

      context 'inquiry not in failed state' do
        before do
          allow(Inquiry).to receive(:find) { inquiry }
          allow(inquiry).to receive(:failed?) { false }
        end

        it 'expect to render error template' do
          post :restart, id: inquiry.id.to_s, format: :json
          expect(response).to render_template('api/v1/errors/show')
        end
      end
    end

    context 'without valid token' do
      it 'expect to render error template' do
        post :restart, id: inquiry.id.to_s, format: :json
        expect(response).to render_template('api/v1/errors/show')
      end
    end

    context 'without abilities' do
      before do
        allow_access_for(user)
        ability.cannot :manage, Inquiry
      end

      it 'expect to render error template' do
        post :restart, id: inquiry.id.to_s, format: :json
        expect(response).to render_template('api/v1/errors/show')
      end
    end
  end
end