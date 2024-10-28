defmodule BitConverter do
  @moduledoc """
  Provides functions to convert between different formats and binary format.
  """

  @doc """
  Converts a binary representing a 16-bit unsigned integer into an integer.
  Raises a FunctionClauseError when the binary has more than 16 bits.

  The endianness can be set in opts. Endian and endianness (or "byte-order") describe how computers
  organize the bytes that make up numbers. By far the most common ordering of multiple bytes in one
  number is the little-endian, which is used on all Intel processors. Little-endian means storing bytes
  in order of least-to-most-significant (where the least significant byte takes the first or lowest address),
  comparable to a common European way of writing dates (e.g., 31 December 2050).

  Naturally, big-endian is the opposite order, comparable to an ISO date (2050-12-31). Big-endian is also
  often called "network byte order", because Internet standards usually require data to be stored big-endian,
  starting at the standard UNIX socket level and going all the way up to standardized Web binary data
  structures. Also, older Mac computers using 68000-series and PowerPC microprocessors formerly used  big-endian.

  (source: https://developer.mozilla.org/en-US/docs/Glossary/Endianness)

  ## Parameters

    - `binary`: A binary pattern that matches a 16-bit unsigned integer.

    - `opts` (Keyword list, optional): Additional options.
      - `:endianness` (atom): `:little` for little-endian or `:big` for big-endian. Defaults to `:little`.

  ## Examples

      iex> BitConverter.to_uint16(<<0, 0>>)
      0

      iex> BitConverter.to_uint16(<<1, 0>>)
      1

      iex> BitConverter.to_uint16(<<10, 0>>)
      10

      iex> BitConverter.to_uint16(<<255, 255>>)
      65535

      iex> BitConverter.to_uint16(<<1, 0>>, endianess: :big)
      256

      iex> BitConverter.to_uint16(<<10, 0>>, endianess: :big)
      2560

      iex> BitConverter.to_uint16(<<255, 255>>, endianess: :big)
      65535

      iex> BitConverter.to_uint16(<<1, 0, 0>>)
      ** (FunctionClauseError) no function clause matching in BitConverter.to_uint16/2

  """
  @spec to_uint16(binary(), keyword()) :: integer()
  def to_uint16(<<num::little-unsigned-integer-size(16)>> = binary, opts \\ []) do
    case Keyword.get(opts, :endianess, :little) do
      :big ->
        <<n::big-unsigned-integer-size(16)>> = binary
        n
      _ -> num
    end
  end
end
