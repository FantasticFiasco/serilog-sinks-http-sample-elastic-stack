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
            // Use the following request URI if you're running this console
            // application in a Docker container
            var requestUri = "http://logstash:31311";

            // Use the following request URI if you're running this console
            // application locally
            //var requestUri = "http://localhost:31311";

            ILogger logger = new LoggerConfiguration()
                .WriteTo.DurableHttpUsingFileSizeRolledBuffers(
                    requestUri: requestUri,
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
