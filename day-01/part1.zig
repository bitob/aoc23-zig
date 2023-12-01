/// https://adventofcode.com/2023/day/1
const std = @import("std");

test "combine first and last digit per line and then add all together" {
    try std.testing.expectEqual(calculate_calibration_value("./test_input1.txt"), 142);
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
    var result: u8 = 0;

    for (line, 0..) |_, i| {
        if (std.ascii.isDigit(line[i])) {
            result = (line[i] - '0') * 10;

            break;
        }
    }

    std.mem.reverse(u8, line);

    for (line, 0..) |_, i| {
        if (std.ascii.isDigit(line[i])) {
            result = result + (line[i] - '0');

            break;
        }
    }

    return result;
}

pub fn main() !void {
    const calibration_value = try calculate_calibration_value("./input1.txt");

    try std.io.getStdOut().writer().print("Calibration Value: {d}\n", .{calibration_value});
}
