using System;

namespace EntityFrameworkMigrations.Models;

public class OrderModel
{
    public int Id { get; set; }
    public required string FirstName { get; set; }
    public required string LastName { get; set; }
    public required string Status { get; set; }
    public DateTime CreateAt { get; set; }
    public Decimal TotalCost { get; set; }
}