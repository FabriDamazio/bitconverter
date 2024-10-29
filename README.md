# BitConverter

BitConverter is a library that provides a straightforward and convenient way to encode and decode binaries. It encapsulates bitstring syntax and Erlang's :binary module functions for encoding and decoding within an easy-to-use API.

## Installation

The package can be installed by adding `bit_converter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bit_converter, "~> 0.1.0"}
  ]
end
```

Run mix `deps.get` in your console to fetch from Hex.

## Usage

```elixir
# decoding
iex> BitConverter.decode_uint16(<<255, 255>>)
65535

iex> BitConverter.decode_int16(<<255, 127>>)
32_767

iex> BitConverter.decode_uint32(<<255, 255, 255, 255>>)
4_294_967_295

iex> BitConverter.decode_int32(<<255, 255, 255, 127>>)
2_147_483_647

# encoding
iex> BitConverter.encode_uint16(65535)
<<255, 255>>

iex> BitConverter.encode_int16(32_767)
<<255, 127>>

iex> BitConverter.encode_uint32(4_294_967_295)
<<255, 255, 255, 255>>

iex> BitConverter.encode_int32(2_147_483_647)
<<255, 255, 255, 127>>

# supports little (default) and big endian
iex> BitConverter.decode_int16(<<10, 0>>, endianess: :little)
10

iex> BitConverter.decode_int16(<<10, 0>>, endianess: :big)
2560
```

## Documentation
Hosted on https://hexdocs.pm/bit_converter

## Author
Fabricio Damazio

BitConverter is released under the MIT License.
