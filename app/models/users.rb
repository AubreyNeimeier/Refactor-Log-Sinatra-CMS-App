class User < ActiveRecord::Base
    has_many :projects
    has_many :concerns, through: :projects
    has_secure_password

    def slug
        #"Hotline Bling" => hotline-bling
        username.downcase.split(/\s*\W/).join("-")
      end

      def self.find_by_slug(slug)
        #binding.pry
        User.all.find {|project| project.slug == slug}
      end


end
