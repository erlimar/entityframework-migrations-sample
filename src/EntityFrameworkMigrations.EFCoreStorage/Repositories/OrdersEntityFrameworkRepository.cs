using System.Threading.Tasks;

using EntityFrameworkMigrations.Models;
using EntityFrameworkMigrations.Orders;

using Microsoft.EntityFrameworkCore;

namespace EntityFrameworkMigrations.EFCoreStorage.Repositories;

public class OrdersEntityFrameworkRepository : IOrdersRepository
{
    private readonly AppDbContext _context;

    public OrdersEntityFrameworkRepository(AppDbContext context)
    {
        _context = context;
    }

    public async Task<Order> CreateOrderAsync(Order newOrder)
    {
        var orderModel = new OrderModel
        {
            FirstName = newOrder.FirstName,
            LastName = newOrder.LastName,
            Status = newOrder.Status,
            CreateAt = newOrder.CreateAt,
            TotalCost = newOrder.TotalCost
        };

        await _context.Orders.AddAsync(orderModel);
        await _context.SaveChangesAsync();

        return new Order
        {
            Id = orderModel.Id,
            FirstName = orderModel.FirstName,
            LastName = orderModel.LastName,
            Status = orderModel.Status,
            CreateAt = orderModel.CreateAt,
            TotalCost = orderModel.TotalCost
        };
    }

    public async Task<Order?> GetOrderByIdAsync(int orderId)
    {
        var orderModel = await _context.Orders.FirstOrDefaultAsync(o => o.Id == orderId);

        return orderModel is null
            ? null
            : new Order
            {
                Id = orderModel.Id,
                FirstName = orderModel.FirstName,
                LastName = orderModel.LastName,
                Status = orderModel.Status,
                CreateAt = orderModel.CreateAt,
                TotalCost = orderModel.TotalCost
            };
    }
}
