module Api
    module V1
        class ArticlesController < ApplicationController
            protect_from_forgery prepend: true

            def index
                articles = Article.order('created_at DESC')
                render json: {status: true, message: 'Loaded Articles', data:articles}, status: :ok
            end

            def show
                begin
                    article = Article.find(params[:id])
                    render json: {status: true, message: 'Loaded Article', data:article}, status: :ok
                rescue => e
                    render json: {status: false, message: e.message}, status: :bad_request
                end
            end

            def create
                article = Article.new(article_params)
                if article.save
                    render json: {status: true, message: 'Saved Article', data:article}, status: :ok
                else
                    render json: {status: false, message: article.errors}, status: :bad_request
                end
            end

            def destroy
                article = Article.find(params[:id])
                article.destroy
                render json: {status: true, message: 'Deleted Article', data:article}, status: :ok
            end

            def update
                article = Article.find(params[:id])
                if article.update(article_params)
                    render json: {status: true, message: 'Updated Article', data:article}, status: :ok
                else
                    render json: {status: false, message: article.errors}, status: :bad_request
                end
            end

            private
                def article_params
                    params.permit(:title, :body)
                end
        end
    end
end