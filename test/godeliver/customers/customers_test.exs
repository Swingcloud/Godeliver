defmodule Godeliver.CustomersTest do
  use Godeliver.DataCase

  alias Godeliver.Customers

  describe "users" do
    alias Godeliver.Customers.User

    @valid_attrs %{name: "some name", phone_number: "some phone_number"}
    @update_attrs %{name: "some updated name", phone_number: "some updated phone_number"}
    @invalid_attrs %{name: nil, phone_number: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Customers.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Customers.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Customers.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Customers.create_user(@valid_attrs)
      assert user.name == "some name"
      assert user.phone_number == "some phone_number"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customers.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Customers.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.name == "some updated name"
      assert user.phone_number == "some updated phone_number"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Customers.update_user(user, @invalid_attrs)
      assert user == Customers.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Customers.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Customers.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Customers.change_user(user)
    end
  end
end
