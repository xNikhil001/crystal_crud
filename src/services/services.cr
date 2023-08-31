require "../db/*"

include Connection

module Service
  def get_data
    data = [] of NamedTuple(name: String, age: Int32 | Int64)

    CONN.query "select name, age from contacts" do |rs|
      rs.each do
        data << {name: rs.read(String), age: rs.read(Int32 | Int64)}
      end
    end

    data.to_json
  end

  def add_data(name : String, age : Int64)
    rs = CONN.query "insert into contacts (name, age) values ('#{name}', '#{age}')"
  end
end
