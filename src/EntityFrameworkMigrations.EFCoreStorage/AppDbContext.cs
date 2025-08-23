using Microsoft.EntityFrameworkCore;

namespace EntityFrameworkMigrations.Models;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    { }

    public DbSet<OrderModel> Orders { get; set; } = null!;
}