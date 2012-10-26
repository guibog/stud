rm -fr _build/
sphinx-build -E -a -b text -d _build/doctrees . _build/text

gl=$@

if [ $# -eq 0 ]
    then gl='*'
fi
IFS=$'\n'

for f in `find test_* -name 'index.rst'`; do
    s="_build/text/`echo $f | sed 's@\.rst$@.txt@'`"
    r="`echo $f | sed 's@index\.rst$@result.txt@'`"
    echo CHECK: comparing "$s" and "$r"
    diff "$s" "$r"
    if [ $? -eq 0 ]
        then echo "OK"
    fi
done

# Use this to update result files
# for f in _build/text/*/index.txt; do cp -f $f `echo $f | sed 's@^_build/text/test\(.*\)/index.txt@test\1/result.txt@'`; done
