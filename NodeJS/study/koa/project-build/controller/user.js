class User {
  async add(ctx, next) {
    ctx.body = 'user add'
  }
  async remove(ctx, next) {
    ctx.body = 'user remove'
  }
}

module.exports = new User()