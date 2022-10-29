#include "HelloWorldStubImpl.hpp"

HelloWorldStubImpl::HelloWorldStubImpl() {}
HelloWorldStubImpl::~HelloWorldStubImpl() {}
void HelloWorldStubImpl::sayHello(const std::shared_ptr<CommonAPI::ClientId> _client, std::string _name, sayHelloReply_t _reply)
{
    std::stringstream messageStream;
    messageStream << "Hello " << _name << "!";
    std::cout << "sayHello('" << _name << "'): '" << messageStream.str() << "'\n";
    _reply(messageStream.str());
};
void HelloWorldStubImpl::onNotifyOnChangeSelectiveSubscriptionChanged(const std::shared_ptr<CommonAPI::ClientId> _client, const CommonAPI::SelectiveBroadcastSubscriptionEvent _event)
{
    std::cout << "[+] client is connected " << _client->hashCode() << std::endl;
}