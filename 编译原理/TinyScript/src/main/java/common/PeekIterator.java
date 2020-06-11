package common;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.stream.Stream;

public class PeekIterator<T> implements Iterator<T> {

    private Iterator<T> it;

    private LinkedList<T> queueCache = new LinkedList<>();
    private LinkedList<T> stackPutBacks = new LinkedList<>();
    private final static int CACHE_SIZE = 10;
    private T _endToken = null;

    public PeekIterator(Stream<T> stream) {
        it = stream.iterator();
    }
    public PeekIterator(Stream<T> stream, T endToken) {
        it = stream.iterator();
        _endToken = endToken;
    }

    public T peek() {
        if (this.stackPutBacks.size() > 0) {
            return this.stackPutBacks.getFirst();
        }
        if (!it.hasNext()) {
            return _endToken;
        }
        T val = next();
        this.putBack();
        return val;
    }

    // 缓存:A -> B -> C -> D
    // 放回:D -> C -> B -> A
    public void putBack() {
        if (this.queueCache.size() > 0) {
            this.stackPutBacks.push(this.queueCache.pollLast());
        }
    }

    @Override
    public boolean hasNext() {
        return _endToken != null || this.stackPutBacks.size() > 0 || it.hasNext();
    }

    @Override
    public T next() {
        T val = null;
        if (this.stackPutBacks.size() > 0) {
            val = this.stackPutBacks.pop();
        } else {
            if (!this.it.hasNext()) {
                T temp = _endToken;
                _endToken = null;
                return temp;
            }
            val = it.next();
        }
        // 判断缓存是否已满
        while(queueCache.size() > CACHE_SIZE - 1) {
            // 删除一个缓存
            queueCache.poll();
        }
        // 增加新缓存
        queueCache.add(val);
        return val;
    }
}
