flutter_distributor package --platform windows --skip-clean --targets msix
for file in dist/*/lubette_todo_flutter-*; do
    new_name=$(echo "$file" | sed -E 's/lubette_todo_flutter-/TodoList-/')
    mv "$file" "$new_name"
done
