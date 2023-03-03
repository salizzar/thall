use std::collections::HashMap;

pub fn fibonacci_generator(index: i128) -> i128 {
    let mut fibonacci: HashMap<i128, i128> = HashMap::new();

    if index < 2 {
        let result = if index < 0 { 0 } else { index };
        return result
    }

    fibonacci.insert(0, 0);
    fibonacci.insert(1, 1);

    for i in 2..=index {
        let n_1 = fibonacci.get(&(i-1));
        let n_2 = fibonacci.get(&(i-2));
        let n = n_1.unwrap() + n_2.unwrap();

        fibonacci.insert(i, n);
    }

    let result = fibonacci.get(&index);
    return *result.unwrap()
}

