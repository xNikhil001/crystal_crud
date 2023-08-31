require "pg"
require "../config"

include Config

module Connection
  CONN = DB.open DB_URL
end
