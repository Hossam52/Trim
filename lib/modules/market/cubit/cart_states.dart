abstract class CartStates
{
  
}
class InitialStateGetCartItems extends CartStates{}
class LoadedStateGetCartItems extends CartStates{}
class AddItem extends CartStates{}
class UpdatedItem extends CartStates{}
class DeleteItem extends CartStates{}
class ErrorState extends CartStates{}