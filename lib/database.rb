require 'pg'

class Database
  def initialize(host:, dbname:, user:, password:, port: 5432)
    @connection = PG.connect(
      host: host,
      dbname: dbname,
      user: user,
      password: password,
      port: port
    )
  end

  def create_table
    result = @connection.exec("SELECT to_regclass('public.prompts_responses') AS table_exists;")
    return if result[0]["table_exists"]

    query = <<-SQL
      CREATE TABLE IF NOT EXISTS prompts_responses (
        id SERIAL PRIMARY KEY,
        prompt TEXT NOT NULL,
        response TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    SQL

    @connection.exec(query)
  end

  def insert(prompt, response)
    query = <<-SQL
      INSERT INTO prompts_responses (prompt, response)
      VALUES ($1, $2)
      RETURNING id, created_at;
    SQL

    result = @connection.exec_params(query, [prompt, response])
    result[0]
  end

  def get_all
    query = "SELECT * FROM prompts_responses ORDER BY created_at DESC;"
    @connection.exec(query).to_a
  end

  def close
    @connection.close
  end
end