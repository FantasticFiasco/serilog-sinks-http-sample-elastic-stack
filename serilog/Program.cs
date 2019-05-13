using System;
using System.Threading;
using Bogus;
using Serilog;
using Serilog.Sinks.Http.BatchFormatters;
using SerilogExample.Generators;

namespace SerilogExample
{
    public class Program
    {
        static void Main()
        {
            ILogger logger = new LoggerConfiguration()
                .WriteTo.DurableHttpUsingFileSizeRolledBuffers(
                    requestUri: "http://logstash:31311",
                    batchFormatter: new ArrayBatchFormatter())
                .WriteTo.Console()
                .CreateLogger()
                .ForContext<Program>();

            var customerGenerator = new CustomerGenerator();
            var orderGenerator = new OrderGenerator();

            while (true)
            {
                var customer = customerGenerator.Generate();
                var order = orderGenerator.Generate();
                
                logger.Information("{@customer} placed {@order}", customer, order);
                
                Thread.Sleep(1000);
            }
        }
    }
}
