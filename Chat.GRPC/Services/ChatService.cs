using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Grpc.Core;
using Microsoft.Extensions.Logging;

namespace Chat.GRPC
{
    public class ChatService : ChatterBox.ChatterBoxBase
    {
        private readonly ILogger<ChatService> _logger;
        public ChatService(ILogger<ChatService> logger)
        {
            _logger = logger;
        }

        public override async Task Chat(Grpc.Core.IAsyncStreamReader<ChatMessage> requestStream, Grpc.Core.IServerStreamWriter<ChatMessage> responseStream, Grpc.Core.ServerCallContext context)
        {
            _logger.LogInformation("New chat connection");
            var separator = ' ';

            while (await requestStream.MoveNext())
            {
                var chatMessage = requestStream.Current;
                _logger.LogInformation($"New incoming message: {chatMessage.Message}");
                var words = chatMessage.Message.Split(separator);
                for (int i = words.Length; i > 0; i--)
                {
                    var message = string.Join(separator, words.TakeLast(i));
                    _logger.LogInformation($"New outgoing message: {message}");
                    var response = new ChatMessage { Message = message };
                    await Task.Delay(1000);
                    await responseStream.WriteAsync(response);
                }
            }
            _logger.LogInformation("End of Chat, end of while movenext");
        }

    }
}
