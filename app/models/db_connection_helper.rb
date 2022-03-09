module DbConnectionHelper
  def self.rename_table(table_name, new_table_name)
    raise "Can't rename for some reason" if table_name == :dummy_table
  end

  def self.execute(_query)
    1
  end

  def self.mysql_adapter?
    false
  end

  def self.adapter_name
    "sqlite3"
  end
end