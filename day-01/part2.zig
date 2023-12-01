/// https://adventofcode.com/2023/day/1#part2
const std = @import("std");

const digits_literals = [_][]const u8{
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
};

const digits_literals_reversed = [_][]const u8{
    "eno",
    "owt",
    "eerht",
    "ruof",
    "evif",
    "xis",
    "neves",
    "thgie",
    "enin",
};

test {
    // TODO: The Test does not work, even the compiler cannot tell me why...
    try std.testing.expectEqual(281, try calculate_calibration_value("./test_input2.txt"));
}

fn check_literals_to_number(str1: []const u8, str2: []const u8) ?u8 {
    if (std.mem.eql(u8, str1, str2)) {
        if (std.mem.eql(u8, str1, "one")) {
            return 1;
        } else if (std.mem.eql(u8, str1, "two")) {
            return 2;
        } else if (std.mem.eql(u8, str1, "three")) {
            return 3;
        } else if (std.mem.eql(u8, str1, "four")) {
            return 4;
        } else if (std.mem.eql(u8, str1, "five")) {
            return 5;
        } else if (std.mem.eql(u8, str1, "six")) {
            return 6;
        } else if (std.mem.eql(u8, str1, "seven")) {
            return 7;
        } else if (std.mem.eql(u8, str1, "eight")) {
            return 8;
        } else if (std.mem.eql(u8, str1, "nine")) {
            return 9;
        }
    }
    return null;
}

fn check_literals_to_number_reversed(str1: []const u8, str2: []const u8) ?u8 {
    if (std.mem.eql(u8, str1, str2)) {
        if (std.mem.eql(u8, str1, "eno")) {
            return 1;
        } else if (std.mem.eql(u8, str1, "owt")) {
            return 2;
        } else if (std.mem.eql(u8, str1, "eerht")) {
            return 3;
        } else if (std.mem.eql(u8, str1, "ruof")) {
            return 4;
        } else if (std.mem.eql(u8, str1, "evif")) {
            return 5;
        } else if (std.mem.eql(u8, str1, "xis")) {
            return 6;
        } else if (std.mem.eql(u8, str1, "neves")) {
            return 7;
        } else if (std.mem.eql(u8, str1, "thgie")) {
            return 8;
        } else if (std.mem.eql(u8, str1, "enin")) {
            return 9;
        }
    }
    return null;
}

fn calculate_calibration_value(file_name: []const u8) !u32 {
    var calibration_value: u32 = 0;

    var file = try std.fs.cwd().openFile(file_name, .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        calibration_value += unamend_line(line);
    }

    return calibration_value;
}

fn unamend_line(line: []u8) u8 {
    const digit_1 = get_unamended_digit(line);

    std.mem.reverse(u8, line);

    const digit_2 = get_unamended_digit_reversed(line);

    return digit_1 * 10 + digit_2;
}

fn get_unamended_digit(line: []u8) u8 {
    for (line, 0..) |_, i| {
        if (std.ascii.isDigit(line[i])) {
            return line[i] - '0';
        } else {
            for (digits_literals) |literal| {
                if ((i + literal.len) < line.len) {
                    const slice = line[i .. i + literal.len];
                    const value = check_literals_to_number(slice, literal);

                    if (value) |FUCK_YOU_ZIG_JUST_LET_ME_SHADOW_THIS_FUCKER| {
                        return FUCK_YOU_ZIG_JUST_LET_ME_SHADOW_THIS_FUCKER;
                    }
                }
            }
        }
    }

    // TODO: Return Error here
    // Make the fucking compiler happy
    return 0;
}

fn get_unamended_digit_reversed(line: []u8) u8 {
    for (line, 0..) |_, i| {
        if (std.ascii.isDigit(line[i])) {
            return line[i] - '0';
        } else {
            for (digits_literals_reversed) |literal| {
                if ((i + literal.len) < line.len) {
                    const slice = line[i .. i + literal.len];
                    const value = check_literals_to_number_reversed(slice, literal);

                    if (value) |FUCK_YOU_ZIG_JUST_LET_ME_SHADOW_THIS_FUCKER| {
                        return FUCK_YOU_ZIG_JUST_LET_ME_SHADOW_THIS_FUCKER;
                    }
                }
            }
        }
    }

    // TODO: Return Error here
    // Make the fucking compiler happy
    return 0;
}

pub fn main() !void {
    const calibration_value = try calculate_calibration_value("./input.txt");

    try std.io.getStdOut().writer().print("Calibration Value: {d}\n", .{calibration_value});
}
