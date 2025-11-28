Return-Path: <linux-sctp+bounces-750-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A681CC91E9F
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Nov 2025 13:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C3184EA454
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Nov 2025 11:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB44430F921;
	Fri, 28 Nov 2025 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leq+IpPJ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DA33126A4
	for <linux-sctp@vger.kernel.org>; Fri, 28 Nov 2025 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330357; cv=none; b=n39tIvMjePijNWBvaKXMfW8c+plA2TOoZ9HqB6RdDTUWPagqT+rcCdQTe66ARxP00u9qo2CfE+3RYdFPRuf+4Ac981hsPiZ0E+2zeocuGxrL0RQl49NMfKDQi2JPwD+GrRDr+GLTaaOMpYUrtby5B/AdfhYSAPjNQV6Z4YpyIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330357; c=relaxed/simple;
	bh=2YRbN/e2slbFuDZyprgcbkHYVPiHV7m/ynPviIf4Lkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOe6p1IsWF+fqnl6HOG8UjL0CaIuATe3C5lT2cBRPxtffS82pTbVpWb0wdXrXbHWGStI+9Hu4keIaxGqnQfOucc4gzXFFntFGWQ1Zrd3wKdjNRzN2L6M4QYT2QHNR6yAIl1epOZNHZNojvVQJLn54CchEByr34uFsJqz79KnusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leq+IpPJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aab7623f42so1913435b3a.2
        for <linux-sctp@vger.kernel.org>; Fri, 28 Nov 2025 03:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764330355; x=1764935155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e7n7+ApfcE1pRInZlg39LMjOnbFZe/xUWP3K8pe6R8s=;
        b=leq+IpPJp+iKXU5TGTBKXkuAXwJdRzWeQ3oKJeLOgpdde1quUlMsXYMA8rfFRwwz8w
         oAA7hWXLB4JBonw5UF9GMlttfeTJartOggR8MM++PwebeG8VxuJ8YXNdw4hQdDTMyKqi
         6cbalHXb139bly2GA4F5W4U0KW3FWQOaK08Z6pwdJ5OQKcFXqoNWPi+fSrsVZW0zVckv
         3/LAmZjM1GkLWsqMXpHaTVfWkkvFulboRmnXLpKM5cTU/9x+ZkCdyBXGMzZx5MegnqH/
         hrOyxdKIdS64yAgDRaVvU5S0f9/TLJ8ZLML6Td53tJirlbZx5T+jXloTH1czb4ZVc/gC
         STmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764330355; x=1764935155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7n7+ApfcE1pRInZlg39LMjOnbFZe/xUWP3K8pe6R8s=;
        b=d/7HPwkpUenwPBVLM2sAhGyW3Y5fpUMXK1XP7vzP1+FLP/v6IN7yswQ7GI2pVud9/Z
         lzVuTKBkwwnt+lfkJVBTkSIDmVHoNLF/DcCchDmMI1nLz0C08XHR/ZUtCcdmoYQzjW9v
         Qlu3oeuQAzA9HiVNXRafeqSfFZ+H57t2tATJloVhCK1JvSt3YSNjmN+Vy0LPkOld2pWa
         kWSWexc9agewPdf4COM9XlBJdZ3g+3+VVj7a1v0Zt4PXTjoszKpz3Z38ua78N6Kbn4B4
         TYg2VluUWJ6/j7oYjqXtshmT76bQ5pAJoMiSi9w/wBwT/twkp0qivfJEb4Y872u+1Vbr
         T5MQ==
X-Gm-Message-State: AOJu0YxIlthFRL6PbzGzpHcNBO0oOsiK60kpjDlXYDWycg0xi3lgCft9
	QNRG6KexWI/B5tTO71kMKqnqnsftVELlc+dnTYotL02o0qd4zaQwl56Q
X-Gm-Gg: ASbGncueM3TwNoowmzvCS+2FKAaBB7Ud/LKxbKOPQ80kaGICSQDNIMlplL0a5qh7t7l
	OYQzOEuPZnU3mh9d4hZOIwXcp/bGUXSDUO+7WtHAoCXYNXwdT3RuY9BSBGmQHBCUiK4kLule9fy
	I0RDb/1rdW9iVgNFdnhsC71pEhWR8zOkcHWt0o0G1aqF296aH4UwHpRH2ttt//6BrVDeAs2Nw+c
	xYB8bNnettDaTKS+Q0TSD/XBYhkoprMY9LFmvmqJwzJAtROMgHzfJGopg4mOBOD9yi4A1tLXu4a
	eKQTplQyzyZUZMpgW925dZf8fcEGu64PfkYKfV+P5vd2jEc+aFEJFBsMs5PU7kdTSTzLpOZ1ZVT
	dqdvDcgo6aeRbnp61BuRP0N/1rHLDKt8EmAWQn5n6fFszz03c8V9BtCr9Q528AnaOey6bpVkzQZ
	jj/lGxZ2ys6A==
X-Google-Smtp-Source: AGHT+IEEh/KLfepRQiKiH0gycBvfNn1MgxncpjWzIHBMW32qZdCRGK48//NA0GzFOcIg+7+5Gl92nQ==
X-Received: by 2002:a05:7022:20f:b0:11b:78e6:8323 with SMTP id a92af1059eb24-11c9d860ee4mr15711090c88.37.1764330355404;
        Fri, 28 Nov 2025 03:45:55 -0800 (PST)
Received: from t14s.localdomain ([2804:29b8:508a:1537::1d7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb057cb0sm20402862c88.9.2025.11.28.03.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 03:45:54 -0800 (PST)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 6802F12A9BB3; Fri, 28 Nov 2025 08:45:52 -0300 (-03)
Date: Fri, 28 Nov 2025 08:45:52 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-sctp@vger.kernel.org
Subject: Re: sctp on RHEL9
Message-ID: <pzrmyhcns6wwyiouqashxwryeakcajvxaqwyr7vl2vxvcwkzi4@eltvekq6ok6n>
References: <20251118230743.5a862e9a@pumpkin>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118230743.5a862e9a@pumpkin>

On Tue, Nov 18, 2025 at 11:07:43PM +0000, David Laight wrote:
> A bit of a gamble...
> 
> Anyone any idea why RHEL9 should reject sctp setsockopt() calls like SCTP_INITMSG?

More likely an invalid buffer as argument. It has to have the exact
size of struct sctp_initmsg, and not more than that.

  Marcelo

