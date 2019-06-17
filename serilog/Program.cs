using System;
using System.Threading;
using Serilog;
using Serilog.Formatting.Json;
using Serilog.Sinks.Http.BatchFormatters;
using SerilogExample.Generators;

namespace SerilogExample
{
    public class Program
    {
        static void Main()
        {
            ILogger logger = GetLogConfiguration()
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

        private static LoggerConfiguration GetLogConfiguration()
        {
            bool.TryParse(Environment.GetEnvironmentVariable("USE_LOGSPOUT"), out var useLogspout);
            if (!useLogspout)
            {
                // log direct to logstash
                return new LoggerConfiguration()
                    .WriteTo.DurableHttpUsingFileSizeRolledBuffers(
                        requestUri: "http://logstash:31311",
                        batchFormatter: new ArrayBatchFormatter())
                    .WriteTo.Console();
            }
            else
            {
                // send logs only to stdout which will then be read by logspout
                return new LoggerConfiguration()
                    .WriteTo.Console(new JsonFormatter());
            }
        }
    }
}
