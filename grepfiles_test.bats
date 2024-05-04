#!/usr/bin/env bats

setup() {
    # Define a temporary file to use for input and output
    TEMP_FILE=$(mktemp)
}

teardown() {
    # Clean up the temporary file after tests
    rm -f "$TEMP_FILE"
}

@test "Script processes input with valid extensions correctly" {
    # Prepare input
    echo "example.jpg some other text example2.7z extra text example3.gif" > "$TEMP_FILE"
    # Run script
    run bash grepfiles.sh < "$TEMP_FILE"
    # Check results
    [ "$status" -eq 0 ]
    [ "$(echo "$output" | sort)" = "$(echo -e "example.jpg\nexample2.7z\nexample3.gif" | sort)" ]
}

@test "Script returns no output for files without valid extensions" {
    # Prepare input
    echo "file.notvalid file.noway another.hmmm" > "$TEMP_FILE"
    # Run script
    run bash grepfiles.sh < "$TEMP_FILE"
    # Check results
    [ "$output" = "" ]
}

@test "Help message is displayed correctly" {
    # Run script
    run bash grepfiles.sh -h
    # Check results
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Usage: grepfiles.sh < file.txt" ]]
}

@test "Script handles unknown option gracefully" {
    # Run script
    run bash grepfiles.sh --unknown
    # Check results
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Unknown option: --unknown" ]]
}

@test "Script handles large file input efficiently" {
    # Create large input file with repeated patterns
    for i in {1..10000}; do
        echo "largefile.mp3 moretext largefile2.zip evenmoretext largefile3.jpeg" >> "$TEMP_FILE"
    done
    # Test performance
    start_time=$(date +%s)
    run bash grepfiles.sh < "$TEMP_FILE"
    end_time=$(date +%s)
    # Check results
    [ "$status" -eq 0 ]
    [ $((end_time - start_time)) -le 5 ]  # Check if script runs in less than or equal to 5 seconds
}