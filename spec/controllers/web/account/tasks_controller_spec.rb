require 'rails_helper'

RSpec.describe Web::Account::TasksController, type: :controller do
  describe 'GET #index' do
    it_behaves_like 'authable' do
      let(:request) { get :index }
    end

    context 'by authenticated user' do
      let(:user) { create(:user) }
      let!(:user_task) { create(:task, user: user) }
      let!(:another_user_task) { create(:task) }

      before do
        sign_in tested_user
        get :index
      end

      context 'by admin user' do
        let(:tested_user) { create(:admin) }

        it 'sets collection of all tasks' do
          expect(assigns(:tasks)).to contain_exactly(user_task, another_user_task)
        end

        it { is_expected.to render_template :index }
      end

      context 'by not admin user' do
        let(:tested_user) { user }

        it "sets collection of only user's tasks" do
          expect(assigns(:tasks)).to contain_exactly(user_task)
        end

        it { is_expected.to render_template :index }
      end
    end
  end

  describe 'GET #show' do
    let(:task_owner) { create(:user) }
    let(:task) { create(:task, user: task_owner) }

    it_behaves_like 'authable' do
      let(:request) { get :show, id: task }
    end

    context 'by authenticated user' do
      shared_examples_for 'successfull show action' do
        it 'sets requested task' do
          expect(assigns(:task)).to eq task
        end

        it { is_expected.to render_template :show }
      end

      before do
        sign_in tested_user
        get :show, id: task
      end

      context 'by admin' do
        let(:tested_user) { create(:admin) }

        it_behaves_like 'successfull show action'
      end

      context 'by not admin' do
        context 'by own task' do
          let(:tested_user) { task_owner }

          it_behaves_like 'successfull show action'
        end

        context 'by other user task' do
          let(:tested_user) { create(:user) }

          it_behaves_like 'authorizable'
        end
      end
    end
  end

  describe 'GET #new' do
    it_behaves_like 'authable' do
      let(:request) { get :new }
    end

    context 'by authenticated user' do
      before do
        sign_in
        get :new
      end

      it { is_expected.to render_template :new }
    end
  end

  describe 'POST #create' do
    it_behaves_like 'authable' do
      let(:request) { post :create }
    end

    context 'by authenticated user' do
      let(:tested_user) { create(:user) }

      before { sign_in tested_user }

      context 'by valid task params' do
        let(:assigned_user) { create(:user) }
        let(:task_params) { attributes_for(:task, user_id: assigned_user.id) }
        let(:request) { post :create, task: task_params }

        context 'by admin' do
          let(:tested_user) { create(:admin) }

          it 'redirects to created task' do
            request
            expect(response).to redirect_to task_path(assigns(:task))
          end

          it 'saves new task to the database and assigns it to the given user' do
            expect { request }.to change(assigned_user.tasks, :count).by(1)
          end
        end

        context 'by not admin' do
          it 'redirects to created task' do
            request
            expect(response).to redirect_to task_path(assigns(:task))
          end

          it 'saves new task to the database and assigns it to current user' do
            expect { request }.to change(tested_user.tasks, :count).by(1)
          end

          it "doesn't assign task to the given user" do
            expect { request }.not_to change(assigned_user.tasks, :count)
          end
        end
      end

      context 'by invalid params' do
        let(:invalid_task_params) { attributes_for(:invalid_task) }
        let(:request) { post :create, task: invalid_task_params }

        it 'renders `new` template' do
          request
          expect(response).to render_template :new
        end

        it "doesn't save task to the database" do
          expect { request }.not_to change(Task, :count)
        end
      end
    end
  end

  describe 'GET #edit' do
    let(:task_owner) { create(:user) }
    let(:task) { create(:task, user: task_owner) }

    it_behaves_like 'authable' do
      let(:request) { get :edit, id: task }
    end

    context 'by authenticated user' do
      shared_examples_for 'successfull edit action' do
        it 'sets requested task' do
          expect(assigns(:task)).to eq task
        end

        it { is_expected.to render_template :edit }
      end

      before do
        sign_in tested_user
        get :edit, id: task
      end

      context 'by admin' do
        let(:tested_user) { create(:admin) }

        it_behaves_like 'successfull edit action'
      end

      context 'by not admin' do
        context 'by own task' do
          let(:tested_user) { task_owner }

          it_behaves_like 'successfull edit action'
        end

        context 'by task of other user' do
          let(:tested_user) { create(:user) }

          it_behaves_like 'authorizable'
        end
      end
    end
  end

  describe 'PATCH #update' do
    let(:task_owner) { create(:user) }
    let!(:task) { create(:task, user: task_owner, name: 'OldName') }

    it_behaves_like 'authable' do
      let(:request) { patch :update, id: task }
    end

    context 'by authenticated user' do
      before { sign_in tested_user }

      context 'by valid task params' do
        let(:new_assignee) { create(:user) }
        let(:task_params) { { user_id: new_assignee.id, name: 'New name' } }
        let(:request) { patch :update, id: task, task: task_params }

        context 'by admin' do
          let(:tested_user) { create(:admin) }

          it 'redirects to task path' do
            request
            expect(response).to redirect_to task_path(task)
          end

          it 'update attributes of task' do
            expect { request }.to change { task.reload.name }.to 'New name'
          end

          it 'assigns task to given user' do
            expect { request }.to change(new_assignee.tasks, :count).by(1)
          end

          it 'removes task from previous user' do
            expect { request }.to change(task_owner.tasks, :count).by(-1)
          end
        end

        context 'by not admin' do
          context 'by owner of task' do
            let(:tested_user) { task_owner }

            it 'redirects to task path' do
              request
              expect(response).to redirect_to task_path(task)
            end

            it 'update attributes of task' do
              expect { request }.to change { task.reload.name }.to 'New name'
            end

            it "doesn't assign task to given user" do
              expect { request }.not_to change(new_assignee.tasks, :count)
            end

            it "doesn't remove task from previous user" do
              expect { request }.not_to change(task_owner.tasks, :count)
            end
          end

          context 'by not owner of task' do
            let(:tested_user) { create(:user) }

            before { patch :update, id: task, task: task_params }

            it_behaves_like 'authorizable'
          end
        end
      end

      context 'by invalid task params' do
        let(:tested_user) { task_owner }

        let(:request) do
          patch :update, id: task, task: { name: nil, description: 'Some description' }
        end

        it 'renders `edit` template' do
          request
          expect(response).to render_template :edit
        end

        it "doesn't change task attributes" do
          expect { request }.not_to change { task.reload.attributes }
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:task_owner) { create(:user) }
    let!(:task) { create(:task, user: task_owner) }

    it_behaves_like 'authable' do
      let(:request) { delete :destroy, id: task }
    end

    context 'by authenticated user' do
      let(:request) { delete :destroy, id: task }

      before { sign_in tested_user }

      shared_examples_for 'successfull destroy' do
        it 'removes task from the databse' do
          expect { request }.to change(Task, :count).by(-1)
        end

        it 'redirect to tasks index path' do
          request
          expect(response).to redirect_to(tasks_path)
        end
      end

      context 'by admin' do
        let(:tested_user) { create(:admin) }

        it_behaves_like 'successfull destroy'
      end

      context 'by not admin' do
        context 'by owner of task' do
          let(:tested_user) { task_owner }

          it_behaves_like 'successfull destroy'
        end

        context 'by not owner of task' do
          let(:tested_user) { create(:user) }

          before { request }

          it_behaves_like 'authorizable'
        end
      end
    end
  end
end
