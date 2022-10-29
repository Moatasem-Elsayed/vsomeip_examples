#include <iostream>
#include <thread>
#include <CommonAPI/CommonAPI.hpp>
#include "HelloWorldStubImpl.hpp"

using namespace std;

int main()
{
	std::shared_ptr<CommonAPI::Runtime> runtime = CommonAPI::Runtime::get();
	std::shared_ptr<HelloWorldStubImpl> myService = std::make_shared<HelloWorldStubImpl>();
	runtime->registerService("local", "test", myService, "test_service");
	std::cout << "Successfully Registered Service!" << std::endl;

	while (true)
	{
		std::cout << "Waiting for calls... (Abort with CTRL+C)" << std::endl;
		std::this_thread::sleep_for(std::chrono::seconds(5));
		myService->fireNotifyOnChangeSelective("hi moatasem");
		std::cout << "fired is done " << std::endl;
	}
	return 0;
}
