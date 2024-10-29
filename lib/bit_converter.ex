defmodule BitConverter do
  @moduledoc """
  Provides functions to convert between different formats and binary format.

  The endianness system used in the conversion can be set in the function's options.
  Endian and endianness (or "byte-order") describe how computers  organize the bytes that make up numbers.
  By far the most common ordering of multiple bytes in one   number is the little-endian, which is used on
  all Intel processors. Little-endian means storing bytes in order of least-to-most-significant
  (where the least significant byte takes the first or lowest address), comparable to a common European
  way of writing dates (e.g., 31 December 2050).

  Naturally, big-endian is the opposite order, comparable to an ISO date (2050-12-31). Big-endian is also
  often called "network byte order", because Internet standards usually require data to be stored big-endian,
  starting at the standard UNIX socket level and going all the way up to standardized Web binary data
  structures. Also, older Mac computers using 68000-series and PowerPC microprocessors formerly used  big-endian.

  (source: https://developer.mozilla.org/en-US/docs/Glossary/Endianness)
  """

  @doc """
  Converts a binary representing a 16-bit unsigned integer into an integer.
  A 16-bit unsigned integer ranges from 0 to 65,535.
  Raises a `FunctionClauseError` if the binary doesn't have exactly 2 bytes.

  ## Parameters

    - `binary`: A binary pattern that matches a 16-bit unsigned integer.

    - `opts` (Keyword list, optional): Additional options.
      - `:endianness` (atom): `:little` for little-endian or `:big` for big-endian. Defaults to `:little`.

  ## Examples

      iex> BitConverter.decode_uint16(<<0, 0>>)
      0

      iex> BitConverter.decode_uint16(<<1, 0>>)
      1

      iex> BitConverter.decode_uint16(<<10, 0>>)
      10

      iex> BitConverter.decode_uint16(<<255, 255>>)
      65535

      iex> BitConverter.decode_uint16(<<1, 0>>, endianess: :big)
      256

      iex> BitConverter.decode_uint16(<<10, 0>>, endianess: :big)
      2560

      iex> BitConverter.decode_uint16(<<255, 255>>, endianess: :big)
      65535

      iex> BitConverter.decode_uint16(<<1, 0, 0>>)
      ** (FunctionClauseError) no function clause matching in BitConverter.decode_uint16/2

  """
  @spec decode_uint16(binary(), keyword()) :: integer()
  def decode_uint16(binary, opts \\ []) when byte_size(binary) == 2 do
    case Keyword.get(opts, :endianess, :little) do
      :big -> :binary.decode_unsigned(binary, :big)
      _ -> :binary.decode_unsigned(binary, :little)
    end
  end

  @doc """
  Converts a binary representing a 16-bit signed integer into an integer.
  A 16-bit signed integer ranges from -32,768 to 32,767.
  Raises a `FunctionClauseError` if the binary doesn't have exactly 2 bytes.

  ## Parameters

    - `binary`: A binary pattern that matches a 16-bit signed integer.

    - `opts` (Keyword list, optional): Additional options.
      - `:endianness` (atom): `:little` for little-endian or `:big` for big-endian. Defaults to `:little`.

  ## Examples

      iex> BitConverter.decode_int16(<<0, 0>>)
      0

      iex> BitConverter.decode_int16(<<10, 0>>)
      10

      iex> BitConverter.decode_int16(<<0, 128>>)
      -32_768

      iex> BitConverter.decode_int16(<<255, 127>>)
      32_767

      iex> BitConverter.decode_int16(<<10, 0>>, endianess: :big)
      2560

      iex> BitConverter.decode_int16(<<0, 128>>, endianess: :big)
      128

      iex> BitConverter.decode_int16(<<255, 127>>, endianess: :big)
      -129

      iex> BitConverter.decode_int16(<<1, 0, 0>>)
      ** (FunctionClauseError) no function clause matching in BitConverter.decode_int16/2

  """
  @spec decode_int16(binary(), keyword()) :: integer()
  def decode_int16(binary, opts \\ []) when byte_size(binary) == 2 do
    unsigned =
      case Keyword.get(opts, :endianess, :little) do
        :big ->
          :binary.decode_unsigned(binary, :big)

        _ ->
          :binary.decode_unsigned(binary, :little)
      end

    if unsigned > 32767 do
      # Convert to signed by subtracting 65536 (2^16)
      unsigned - 65536
    else
      unsigned
    end
  end

  @doc """
  Converts a binary representing a 32-bit unsigned integer into an integer.
  A 32-bit unsigned integer ranges from 0 a 4.294.967.295.
  Raises a `FunctionClauseError` if the binary doesn't have exactly 4 bytes.

  ## Parameters

    - `binary`: A binary pattern that matches a 32-bit unsigned integer.

    - `opts` (Keyword list, optional): Additional options.
      - `:endianness` (atom): `:little` for little-endian or `:big` for big-endian. Defaults to `:little`.

  ## Examples

      iex> BitConverter.decode_uint32(<<0, 0, 0, 0>>)
      0

      iex> BitConverter.decode_uint32(<<1, 0, 0 , 0>>)
      1

      iex> BitConverter.decode_uint32(<<10, 0, 0, 0>>)
      10

      iex> BitConverter.decode_uint32(<<255, 255, 255, 255>>)
      4_294_967_295

      iex> BitConverter.decode_uint32(<<1, 0, 0, 0>>, endianess: :big)
      16_777_216

      iex> BitConverter.decode_uint32(<<10, 0, 0, 0>>, endianess: :big)
      167_772_160

      iex> BitConverter.decode_uint32(<<255, 255, 255, 255>>, endianess: :big)
      4_294_967_295

      iex> BitConverter.decode_uint32(<<1, 0, 0, 0, 0>>)
      ** (FunctionClauseError) no function clause matching in BitConverter.decode_uint32/2

  """
  @spec decode_uint32(binary(), keyword()) :: integer()
  def decode_uint32(binary, opts \\ []) when byte_size(binary) == 4 do
    case Keyword.get(opts, :endianess, :little) do
      :big -> :binary.decode_unsigned(binary, :big)
      _ -> :binary.decode_unsigned(binary, :little)
    end
  end

  @doc """
  Converts a binary representing a 32-bit signed integer into an integer.
  A 32-bit signed integer ranges from -2.147.483.648 a 2.147.483.647.
  Raises a `FunctionClauseError` when the binary has more than 32 bits.

  ## Parameters

    - `binary`: A binary pattern that matches a 32-bit signed integer.

    - `opts` (Keyword list, optional): Additional options.
      - `:endianness` (atom): `:little` for little-endian or `:big` for big-endian. Defaults to `:little`.

  ## Examples

      iex> BitConverter.decode_int32(<<0, 0, 0, 0>>)
      0

      iex> BitConverter.decode_int32(<<10, 0, 0, 0>>)
      10

      iex> BitConverter.decode_int32(<<0, 0, 0, 128>>)
      -2_147_483_648

      iex> BitConverter.decode_int32(<<255, 255, 255, 127>>)
      2_147_483_647

      iex> BitConverter.decode_int32(<<1, 0, 0, 0>>, endianess: :big)
      16_777_216

      iex> BitConverter.decode_int32(<<10, 0, 0, 0>>, endianess: :big)
      167_772_160

      iex> BitConverter.decode_int32(<<255, 255, 255, 127>>, endianess: :big)
      -129

      iex> BitConverter.decode_int32(<<1, 0, 0, 0, 0>>)
      ** (FunctionClauseError) no function clause matching in BitConverter.decode_int32/2

  """
  @spec decode_int32(binary(), keyword()) :: integer()
  def decode_int32(binary, opts \\ []) when byte_size(binary) == 4 do
    unsigned =
      case Keyword.get(opts, :endianess, :little) do
        :big ->
          :binary.decode_unsigned(binary, :big)

        _ ->
          :binary.decode_unsigned(binary, :little)
      end

    if unsigned >  2_147_483_647 do
      # Convert to signed by subtracting 4_294_967_296 (2^32)
      unsigned - 4_294_967_296
    else
      unsigned
    end
  end

  @doc """
  Converts an integer into a binary representing a 16-bit unsigned integer.
  A 16-bit unsigned integer ranges from 0 to 65,535.
  Raises a `FunctionClauseError` if the number is outside the valid range.

  ## Parameters

    - `number`: An integer that fits in a 16-bit unsigned integer.

    - `opts` (Keyword list, optional): Additional options.
      - `:endianness` (atom): `:little` for little-endian or `:big` for big-endian. Defaults to `:little`.

  ## Examples

      iex> BitConverter.encode_uint16(1)
      <<1, 0>>

      iex> BitConverter.encode_uint16(65535)
      <<255, 255>>

      iex> BitConverter.encode_uint16(256, endianess: :big)
      <<1, 0>>

      iex> BitConverter.encode_uint16(65536)
      ** (FunctionClauseError) no function clause matching in BitConverter.encode_uint16/2

      iex> BitConverter.encode_uint16(-1)
      ** (FunctionClauseError) no function clause matching in BitConverter.encode_uint16/2

  """
  @spec encode_uint16(integer(), keyword()) :: binary()
  def encode_uint16(number, opts \\ []) when number >= 0 and number <= 65_535 do
    case Keyword.get(opts, :endianess, :little) do
      :big -> <<number::big-unsigned-16>>
      _ -> <<number::little-unsigned-16>>
    end
  end
end
