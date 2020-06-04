const sql = require('mssql')
const config = {
  user: 'cop',
  password: 'A!12345',
  server: 'localhost',
  database: 'PIMSV2'
}

const poolPromise = new sql.ConnectionPool(config)
  .connect()
  .then(pool => {
    console.log('Connected to MSSQL')
    return pool
  })
  .catch(err => console.log('Database Connection Failed! Bad Config: ', err))

module.exports = {
  sql, poolPromise
}