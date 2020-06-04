const {sql, poolPromise} = require('../db.js');

exports.ka3794 = async (req, res) => {
  const pool = await poolPromise;
  const result = await pool.request()
    .execute('dbo.COP_ProcLogic');
    
  return res.json(result.recordsets);
};
