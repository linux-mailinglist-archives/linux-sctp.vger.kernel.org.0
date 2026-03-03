Return-Path: <linux-sctp+bounces-945-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHhdJwALp2kDcgAAu9opvQ
	(envelope-from <linux-sctp+bounces-945-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 03 Mar 2026 17:23:28 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC9A1F3AD8
	for <lists+linux-sctp@lfdr.de>; Tue, 03 Mar 2026 17:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CF8530518E8
	for <lists+linux-sctp@lfdr.de>; Tue,  3 Mar 2026 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16AD4D2EF5;
	Tue,  3 Mar 2026 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AwjiNWln"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DA64D2EF0
	for <linux-sctp@vger.kernel.org>; Tue,  3 Mar 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554672; cv=pass; b=pw4xv4Gy9ZSPQBMnEkOxfk8hJb0cQfA0D9mQYy41UpBBlPyv2k6XGiSFQ3qFhBtrm+iVRA0ghv2g7D+qlX7bfxeVJ1gvu27zbQdQpST7gvbZ40I4qas/G2PTvtHE0hlyueDpRlgkvBeV6nQtAQ3OpObgoJ0EJW7Riu0EBsZ0LY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554672; c=relaxed/simple;
	bh=D31bfjZSP/L0HElgbPJEOIXXw9PZR2MgXoaqrLT9Rqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hv4BdbRlEIrdQhxnBM20ng61vphLPqVcuLR2vDWB8y1V9YgY1ZRl9zCQcYJzAFxThuX8MJHPrvOqxac7lbiV4+T8T6cmMz9/GEzo/olqXCb6i06JzjK3GEKZhvYEiXnlElHte6T4L/R4xYbsnHL/iu1dWErEGCMeqYNSDkFz5Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AwjiNWln; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82418b0178cso3394572b3a.1
        for <linux-sctp@vger.kernel.org>; Tue, 03 Mar 2026 08:17:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772554668; cv=none;
        d=google.com; s=arc-20240605;
        b=iBp21zgRdrzL8CgNcel84kN6K/ujaNvJxIAAfXsmmYeab79qDdLmVrgp2OwqCGvm9h
         0bQ8qTRJQNl9Hs94bvYQyL+3D7tlqUxh+ITIi/HNkaqhVNdvp418e6mKe+MI3sIzReDB
         WwCJ95Z9QjkAAvwytJLXZum8OVjseCk85j66A8KOGrluInQy6l1c8tkWJ7Bqf/its2it
         rW8EZUqp6W5kK9MysJ+EETuq75G1Y0zS+pcGiDhaedrNkzDkrAH6k7KHAeLbiyKkKTYj
         owXCewSmSSPVoZ348M8M6pK2pTrGZ1l2DiSpC4khz4M1D/ark/CAVSXwD0UiK3PFjXIP
         x29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vlM0HTuT+/Lu8GovscjfA3KZuqms5GnXWRMciKBvDhQ=;
        fh=WaY1QBa6PoqrR4JyKDn5GZ4jFC45JYg/6BL7fqLgcFM=;
        b=Gx5FBNEHHoBp/pPnoB0jrtI9fYCesVjST6s2RuqHi5y/kr5r7YkCxJEGzkXepxPSZR
         klD7lE0wcgOh4aNw/G+oZZgV6qF8V7L/dng363OvXcIbn8HgG99HME53iUqI0UFFU73d
         JAcuaaeeuFYwhUuq/PDoodCJtYRWQka5xCA3iVohgNnY9YKGBZ7O0ecydj8Khf+vew7e
         LsWKsEy11Rvb8VvDh7+QdrXVrMG0GMOvO8Vw0MgpLiSdLRnZw4bdfHKxhDWP7C4Dw79Y
         EVh9Ofrw6g7GBoj88Ub6VG6cDWIbnL09vFGXJRHHRyrFn6ffuR0bZ3pwL+8Wx0Enuzmn
         rL0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772554668; x=1773159468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlM0HTuT+/Lu8GovscjfA3KZuqms5GnXWRMciKBvDhQ=;
        b=AwjiNWln5JR6BxSrUTDTHA+0IzNH6y/wDyQd8wA8GmdtuWg0T7RL0eJsZE/3cD7JTN
         J+fLhSw6cPUycqgFu+Q+/ajM7Sji9fBJ6gnOrRT/Q+DNeGveICu3p2iA2h+bvcTk+GxF
         /XoXg8WhQpUAUJIVoH0tjyBT4Mi8qy90ohn7q6lOW9FLjyXLXB0q6aBZ6q0wprJV1GPR
         l4JDkYfvmZkRb++O8RFLWEKuhno69fazyKkVXzVUU6RSzmGNni/ji6h3OTvSd+Jw9IhG
         AjnormoIAmc8F7TR4h6EwKoARQfPCyOSvgMgqLHIlMLTs/a79zkB4RSFwd61MxtDZzz9
         yJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772554668; x=1773159468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vlM0HTuT+/Lu8GovscjfA3KZuqms5GnXWRMciKBvDhQ=;
        b=kVp/Iz2GSZrKj7N82tk+E9vAabP9Wu4Y4IAwaKWyIfddRwox0Zb0RsnDrKnDP4ZNa6
         aFgc06uELmBdxTsDdoUipexOFpWTPjCHEBqKxcoC9E98We6My8o4r1ceNfk+8L2SSx1c
         mYZcs+pLVaLvyHzCiQWgfuhyd4oKAcvhgY2IMGULfsyCVmuZPLL0I1Z9iesR6askilWr
         TUNC221lWwBGBa4dL7Qc2LRG41SrD52CHo++ljTFop/2zXWyxZRgxMDumEbBYrEQogpa
         9r7cOaFrWpvPVBhkFBsfExDUhP+pQ94Uj7VJqiR/FwAJd6/HANXmUIPVE6hVBxqrwV6+
         pYIg==
X-Forwarded-Encrypted: i=1; AJvYcCXOB/LZfVU3Uz5S/+yOXzBK+n7cKX0nvWDM5izhFC5+C5w5Dw5NMhGGqjUel0ooEWHGdMg8EjVfX9jc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz19qu4bsmsmBdjd3ZBtVI9MTEtuBlhlHvVv04VcIwTsP/qSYFW
	p3NBw3rbKFZnxFZmYhYubBdNhmvydm+yICH7Wcogknm0x+HuTP3GAMztJKninKqJ3JRkQfmuDzg
	gT0U9mr5u81yDPp0NBiO6d6I3Zg/5iaOAwJ6Vho7k
X-Gm-Gg: ATEYQzysWW815uEeFLZWzxkPwFaQgQQmeRiWISB8n5rd2RCHr3GXg8coIzVb2rZR02Y
	S4xJ/D9lHjzd77rIuZ1D+0I6fYcO5ckRREc90IO6318BOH3WOrveRwqmSERjao3WXulhThDZiPI
	x3RS10Knnk8XG2l9aT8i5jF8HTpXfyMlEsLzXRCCGrEo5OdWE0X8AWN/tec+XbvqOH3VxdsRl7u
	ZeyU0Yp7Sc0NEQ3c18CIbOiwgu//pP2boQm1F6oGC9F/6qj9hLNFEswfExIvoMRZP6KKBjo+Mfo
	nxtBSyY=
X-Received: by 2002:a17:90b:4c12:b0:359:8d70:c4e6 with SMTP id
 98e67ed59e1d1-3598d70c5admr5344309a91.1.1772554667658; Tue, 03 Mar 2026
 08:17:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <20260302-iino-u64-v2-3-e5388800dae0@kernel.org> <CAHC9VhRnmBuXEKkUPQhJ_LDzcksjoAJL-ne6mFoJdR1hnDdzsg@mail.gmail.com>
 <7a0165fe39e82a1effd8cce5c2c4e82d6a42cb3a.camel@kernel.org>
 <CAHC9VhTyhnG7-ojnTnVdh_m1x=rKxw9YEH9g7Xp9m4F78aA5cA@mail.gmail.com> <add39953250a4a1b2fe2b09deb3373c2a7482b88.camel@kernel.org>
In-Reply-To: <add39953250a4a1b2fe2b09deb3373c2a7482b88.camel@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Mar 2026 11:17:34 -0500
X-Gm-Features: AaiRm503AvilRZsmzje3hsLVwZQN2UeIDoaYrT0wwtgoCj-_LcRzyWRvZdGrFAo
Message-ID: <CAHC9VhSb3nAsJBxhqitDVQw=J8hX1CJDe1xqL-JMjOA5J4tUkw@mail.gmail.com>
Subject: Re: [PATCH v2 003/110] audit: widen ino fields to u64
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Steve French <sfrench@samba.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Alexander Aring <alex.aring@gmail.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>, Amir Goldstein <amir73il@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Martin Schiller <ms@dev.tdt.de>, Eric Paris <eparis@redhat.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-x25@vger.kernel.org, audit@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5BC9A1F3AD8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.org];
	TAGGED_FROM(0.00)[bounces-945-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[171];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,paul-moore.com:dkim,paul-moore.com:url,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 11:12=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
> On Tue, 2026-03-03 at 11:03 -0500, Paul Moore wrote:
> > On Tue, Mar 3, 2026 at 6:05=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > > On Mon, 2026-03-02 at 18:44 -0500, Paul Moore wrote:
> > > > On Mon, Mar 2, 2026 at 3:25=E2=80=AFPM Jeff Layton <jlayton@kernel.=
org> wrote:
> > > > >
> > > > > inode->i_ino is being widened from unsigned long to u64. The audi=
t
> > > > > subsystem uses unsigned long ino in struct fields, function param=
eters,
> > > > > and local variables that store inode numbers from arbitrary files=
ystems.
> > > > > On 32-bit platforms this truncates inode numbers that exceed 32 b=
its,
> > > > > which will cause incorrect audit log entries and broken watch/mar=
k
> > > > > comparisons.
> > > > >
> > > > > Widen all audit ino fields, parameters, and locals to u64, and up=
date
> > > > > the inode format string from %lu to %llu to match.
> > > > >
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  include/linux/audit.h   | 2 +-
> > > > >  kernel/audit.h          | 9 ++++-----
> > > > >  kernel/audit_fsnotify.c | 4 ++--
> > > > >  kernel/audit_watch.c    | 8 ++++----
> > > > >  kernel/auditsc.c        | 2 +-
> > > > >  5 files changed, 12 insertions(+), 13 deletions(-)
> > > >
> > > > We should also update audit_hash_ino() in kernel/audit.h.  It is a
> > > > *very* basic hash function, so I think leaving the function as-is a=
nd
> > > > just changing the inode parameter from u32 to u64 should be fine.
> >
> > ...
> >
> > > It doesn't look like changing the argument type will make any materia=
l
> > > difference. Given that it should still work without that change, can =
we
> > > leave this cleanup for you to do in a follow-on patchset?
> >
> > I would prefer if you made the change as part of the patch, mainly to
> > keep a patch record of this being related.
>
> Ok, I'll see about factoring that in.

Thanks.

> > Ideally I'd really like to see kino_t used in the audit code instead
> > of u64, but perhaps that is done in a later patch that I didn't see.
>
> I think I didn't make this clear enough in the cover letter, but kino_t
> is removed at the end of the series. It's just there to support the
> change during the interim.

Ah, gotcha, thanks for the education :)

> If HCH gets his way to do the changes as one big patch, it'll go away
> entirely.

--=20
paul-moore.com

