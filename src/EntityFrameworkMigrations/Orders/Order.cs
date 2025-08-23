using System;

namespace EntityFrameworkMigrations.Orders;

public class Order
{
    public int Id { get; set; }
    public required string FirstName { get; set; }
    public required string LastName { get; set; }
    public required string Status { get; set; }
    public DateTime CreateAt { get; set; }
    public decimal TotalCost { get; set; }
}
