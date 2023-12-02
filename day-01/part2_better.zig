/// https://adventofcode.com/2023/day/1#part2
const std = @import("std");

const Digit = struct {
    num: u8,
    str: []const u8,
};

const digits = [_]Digit{
    Digit{ .num = 1, .str = "one" },
    Digit{ .num = 2, .str = "two" },
    Digit{ .num = 3, .str = "three" },
    Digit{ .num = 4, .str = "four" },
    Digit{ .num = 5, .str = "five" },
    Digit{ .num = 6, .str = "six" },
    Digit{ .num = 7, .str = "seven" },
    Digit{ .num = 8, .str = "eight" },
    Digit{ .num = 9, .str = "nine" },
};

test {
    // TODO: The Test does not work, even the compiler cannot tell me why...
    try std.testing.expectEqual(281, try calculate_calibration_value("./test_input2.txt"));
}

fn calculate_calibration_value(file_name: []const u8) !u32 {
    var calibration_value: u32 = 0;

    var file = try std.fs.cwd().openFile(file_name, .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        std.debug.print("Line: {s}\n", .{line});

        var first_digit: u8 = 255;
        var second_digit: u8 = 255;

        for (line, 0..) |_, i| {
            std.debug.print("Looking at: {c}\n", .{line[i]});
            if (std.ascii.isDigit(line[i])) {
                std.debug.print("Digit Matched\n", .{});
                if (first_digit == 255) {
                    first_digit = line[i] - '0';
                }
                second_digit = line[i] - '0';
            } else {
                for (digits, 0..) |_, j| {
                    if ((i + digits[j].str.len) <= line.len) {
                        const slice = line[i .. i + digits[j].str.len];
                        const digit_str = digits[j].str[0..digits[j].str.len];

                        std.debug.print("Slice: {s}\nDigitStr: {s}\n", .{ slice, digit_str });

                        if (std.mem.eql(u8, slice, digit_str)) {
                            std.debug.print("Slice Matched\n", .{});
                            if (first_digit == 255) {
                                first_digit = digits[j].num;
                            }
                            second_digit = digits[j].num;

                            break;
                        }
                    }
                }
            }
        }

        std.debug.print("Digits: {d} {d}\n", .{ first_digit, second_digit });

        calibration_value += first_digit * 10 + second_digit;
    }

    return calibration_value;
}

pub fn main() !void {
    const calibration_value = try calculate_calibration_value("./input.txt");

    try std.io.getStdOut().writer().print("Calibration Value: {d}\n", .{calibration_value});
}
