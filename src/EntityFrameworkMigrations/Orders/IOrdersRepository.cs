using System.Threading.Tasks;

namespace EntityFrameworkMigrations.Orders;

public interface IOrdersRepository
{
    Task<Order> CreateOrderAsync(Order newOrder);
    Task<Order?> GetOrderByIdAsync(int orderId);
}
