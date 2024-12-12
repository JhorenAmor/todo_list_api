# frozen_string_literal: true

module Api
  module V1
    class NamespaceController < ApplicationController
      before_action :authenticate_request

      private

      def authenticate_request
        api_key = request.headers['Authorization']
        return unless api_key != ENV['API_KEY']

        head :unauthorized
        nil
      end
    end
  end
end
